 package it.SpaceComix.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import it.SpaceComix.model.Carrello;
import it.SpaceComix.model.FatturaGenerator;
import it.SpaceComix.model.ProdottoCarrello;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import java.util.logging.Logger;


 @WebServlet("/generaFattura")
public class generaFattura extends HttpServlet {


	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Carrello cart = (Carrello) request.getSession().getAttribute("cart");


 // Metodo per ottenere il carrello con i prodotti

        try {

            PDDocument document = new PDDocument();
            PDPage page = new PDPage(PDRectangle.A4);
            document.addPage(page);

            PDPageContentStream contentStream = new PDPageContentStream(document, page);
            contentStream.beginText();
            // Aggiungi il titolo della fattura
            contentStream.newLineAtOffset(50, 700);
            contentStream.showText("Fattura");

            // Aggiungi le info
            contentStream.newLineAtOffset(50, 650);

            double totaleFattura = 0;

            for (ProdottoCarrello prodotto : cart.getProducts()) {
                String nomeProdotto = prodotto.getProdotto().getTitolo();
                String descrizione = prodotto.getProdotto().getDescrizione();
                int quantita = prodotto.getQuantita();
                double prezzoSingolo = prodotto.getProdotto().getPrezzo();
                double totaleProdotto = quantita * prezzoSingolo;
                double iva = totaleProdotto * 0.22; // Assumiamo che l'IVA sia del 22%


                // Carica l'immagine del prodotto
                PDImageXObject image = PDImageXObject.createFromFile("Immagini/" + prodotto.getProdotto().getImage(), document);
                contentStream.drawImage(image, 200, 650, 150, 150); // Posizione e dimensioni immagine


                contentStream.showText("Prodotto: " + nomeProdotto);
                contentStream.newLine();
                contentStream.showText("Descrizione: " + descrizione);
                contentStream.newLine();
                contentStream.showText("Quantità: " + quantita);
                contentStream.newLine();
                contentStream.showText("Prezzo singolo: " + prezzoSingolo);
                contentStream.newLine();
                contentStream.showText("Totale: " + totaleProdotto);
                contentStream.newLine();
                contentStream.showText("IVA: " + iva);
                contentStream.newLine();

                totaleFattura += totaleProdotto;
            }

            contentStream.showText("Totale Fattura: " + totaleFattura);

            contentStream.endText();
            contentStream.close();


            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"fattura.pdf\"");
            document.save(response.getOutputStream());

            document.close();
        } catch (IOException e) {
            e.printStackTrace();
        }



        //response.sendRedirect("/conferma-checkout.jsp");
    }
}
