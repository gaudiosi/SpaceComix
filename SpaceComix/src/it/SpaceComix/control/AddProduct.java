package it.SpaceComix.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.SpaceComix.model.ProductBean;
import it.SpaceComix.model.ProductDAO;
import it.SpaceComix.model.CategoriaDAO;
import it.SpaceComix.model.CategoriaBean;

import java.io.*;
import java.nio.file.*;
import javax.servlet.http.*;
import org.apache.commons.io.*;


@WebServlet("/AddProduct")
@MultipartConfig
public class AddProduct extends HttpServlet {
    private static final String DIRECTORY_PATH = "Immagini";

    private static final long serialVersionUID = 1L;

    public AddProduct() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	
        Part filePart = request.getPart("file");
        String fileName = getFileName(filePart);
        String filePath = DIRECTORY_PATH + File.separator + fileName;
        Files.createDirectories(Paths.get(DIRECTORY_PATH));
        
        try (InputStream inputStream = filePart.getInputStream(); OutputStream outputStream = new FileOutputStream(filePath)) {
               		IOUtils.copy(inputStream, outputStream);
           	}
        
        boolean errore = false;
        HttpSession session = request.getSession();
        ProductBean product = new ProductBean();
        product.setPrezzo(Float.parseFloat(request.getParameter("prezzo")));
        product.setTitolo(request.getParameter("titolo"));
        product.setDescrizione(request.getParameter("descrizione"));
        product.setAutore(request.getParameter("autore"));
        product.setEditore(request.getParameter("editore"));
        product.setIsbn(request.getParameter("isbn"));
        product.setQuantita(Integer.parseInt(request.getParameter("quantita")));
        product.setIva(Integer.parseInt(request.getParameter("iva")));
        product.setImage(fileName);
        
        String imagine_alt = "Copertina del volume di "+product.getTitolo();
        product.setImage_alt(imagine_alt);
        
        product.setSconto(Integer.parseInt(request.getParameter("sconto")));
        
        //PARTE DI CONVERSIONE DA STRINGHE A ARRAYLIST<CategoriaBean>
        String[] categorieSelezionate = request.getParameterValues("categorie");
        ArrayList<CategoriaBean> generi = new ArrayList<CategoriaBean>();
		CategoriaDAO cdao = new CategoriaDAO();
		String ord = "nome DESC";
		Collection<CategoriaBean> categorie = null;
		try {
			categorie = cdao.doRetrieveAll(ord);
		} catch (SQLException e) {
			errore = true;
		}

        if(categorieSelezionate!= null)
        {
            for (String cs : categorieSelezionate) {
                for (CategoriaBean c : categorie) {
                    if (c.getNome().equals(cs)) {
                        generi.add(c);
                        break;
                    }
                }
            }
            product.setGeneri(generi);
        }



        //PARTE DI CONVERSIONE DA STRINGHE A ARRAYLIST<CategoriaBean>

        String isbnRegex = "^978-[0-9]{1,5}-[0-9]{1,7}-[0-9]{1,6}-[0-9]$";
        if (!product.getIsbn().matches(isbnRegex)) {
            String error = "Invalid ISBN format. Please try again.";
            session.setAttribute("error", error);
            response.sendRedirect("AddProdotto.jsp");
            return;
        }

        ProductDAO productDao = new ProductDAO();
        try {
            productDao.doSave(product);
        } catch (Exception e) {
            errore = true;
        }

        if (!errore) {
            session.setAttribute("success", "Prodotto aggiunto.");
            response.sendRedirect("index.jsp");
        } else {
            String error = "errore, ritenta.";
            session.setAttribute("error", error);
            response.sendRedirect("AddProdotto.jsp");
        }
    }
    
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] elements = contentDisposition.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(element.indexOf("=") + 1).trim().replace("\"", "");
            }
        }
        return "file";
    }
}
