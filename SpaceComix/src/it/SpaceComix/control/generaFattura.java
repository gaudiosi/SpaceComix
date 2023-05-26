 package it.SpaceComix.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import it.SpaceComix.model.Carrello;
import it.SpaceComix.model.ProdottoCarrello;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;
//import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

//import java.util.logging.Logger;


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

            
            //stream
            PDPageContentStream contentStream = new PDPageContentStream(document, page);
            contentStream.beginText();
            
            /* IMMAGINE
// Carica l'immagine del logo
PDImageXObject logoImage = PDImageXObject.createFromFile("svgtest/Logo.png", document);

// Coordinate del logo
float logoX = 50; // Coordinata X (margine sinistro)
float logoY = PDRectangle.A4.getHeight() - 50 - logoImage.getHeight(); // Coordinata Y (altezza_pagina - margine superiore - altezza_logo)

// Dimensioni del logo
float logoWidth = 100; // Larghezza del logo
float logoHeight = 50; // Altezza del logo

// Disegna il logo sulla pagina
contentStream.drawImage(logoImage, logoX, logoY, logoWidth, logoHeight);
            */
            
            
            // Aggiungi il titolo della fattura
            PDFont HelveticaBold=  new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD);
            PDFont Helvetica=  new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD);
            contentStream.setFont(HelveticaBold, 16);
            contentStream.newLineAtOffset(50, 700);
            contentStream.showText("Fattura");
            
            
            contentStream.newLineAtOffset(0, -20);



            // Aggiungi le info
            contentStream.setFont(Helvetica, 12);


            double totaleFattura = 0;

            for (ProdottoCarrello prodotto : cart.getProducts()) {
                String nomeProdotto = prodotto.getProdotto().getTitolo();
                String descrizione = prodotto.getProdotto().getDescrizione();
                int quantita = prodotto.getQuantita();
                double prezzoSingolo = prodotto.getProdotto().getPrezzo();
                double totaleProdotto = quantita * prezzoSingolo;
                double ivap = prodotto.getProdotto().getIva();
                double iva = totaleProdotto * (ivap/100);


                // Carica l'immagine del prodotto


                contentStream.showText("Prodotto: " + nomeProdotto);
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("Descrizione: " + descrizione);
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("Quantit�: " + quantita);
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("Prezzo singolo: " + String.format("%.2f",prezzoSingolo)+"�");
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("Totale: " + String.format("%.2f",totaleProdotto)+"�");
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("IVA: " + String.format("%.2f",iva)+"�" + " (" + ivap + "%)");
                contentStream.newLineAtOffset(0, -50);

                totaleFattura += totaleProdotto;
            }

            contentStream.showText("Totale Fattura: " + String.format("%.2f",totaleFattura)+"�");

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
