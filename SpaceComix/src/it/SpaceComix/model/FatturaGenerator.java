package it.SpaceComix.model;
import java.io.IOException;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;

import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;

import it.SpaceComix.model.ProdottoCarrello;
import it.SpaceComix.model.Carrello;

public class FatturaGenerator {
    public static void main(Carrello cart2) {
    	Carrello cart = cart2; // Metodo per ottenere il carrello con i prodotti
        
        try {
            final PDDocument document = new PDDocument();
            PDPage page = new PDPage(PDRectangle.A4);
            document.addPage(page);

            PDPageContentStream contentStream = new PDPageContentStream(document, page);
            
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
            
            contentStream.close();

            document.save("fattura.pdf");
            document.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
