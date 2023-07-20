package it.SpaceComix.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.SpaceComix.model.*;

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

        UserBean user = (UserBean) request.getSession().getAttribute("user");
        if (user == null || !user.getRuolo().equals("admin")) {
            response.sendError(401, "Soggetto non autorizzato ad accedere alla pagina");
        }
        else {
            if(request.getParameter("action").equals("modifica"))
            {
                String productid = request.getParameter("id");
                if(productid!=null)
                {
                    try {

                        ProductBean prodotto = new ProductDAO().doRetrieveByKey(Integer.parseInt(productid));
                        request.setAttribute("prodotto", prodotto);

                        Collection<CategoriaBean> categorie = new CategoriaDAO().doRetrieveAll("nome DESC ");
                        request.setAttribute("categorie", categorie);

                        RequestDispatcher dispatcher= request.getServletContext().getRequestDispatcher("/EditProdotto.jsp");
                        dispatcher.forward(request,response);




                    }
                    catch (SQLException e)
                    {
                        response.sendError(500, "Errore nell'elaborazione del server");
                    }
                }
                else response.sendRedirect("Home"); //da vedere
            }
        }
    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserBean user = (UserBean) request.getSession().getAttribute("user");
        if (user == null || !user.getRuolo().equals("admin")) {
            response.sendError(401, "Soggetto non autorizzato ad accedere alla pagina");
        }
        else {
            boolean errore = false;

            HttpSession session = request.getSession();
            ProductBean product = new ProductBean();


            if (request.getParameter("action").equals("add") || request.getParameter("action").equals("modifica")) {
                Part filePart = request.getPart("file");
                String fileName = getFileName(filePart);
                String filePath = DIRECTORY_PATH + File.separator + fileName;
                Files.createDirectories(Paths.get(DIRECTORY_PATH));

                try (InputStream inputStream = filePart.getInputStream(); OutputStream outputStream = new FileOutputStream(filePath)) {
                    IOUtils.copy(inputStream, outputStream);
                }

                product.setPrezzo(Float.parseFloat(request.getParameter("prezzo")));
                product.setTitolo(request.getParameter("titolo"));
                product.setDescrizione(request.getParameter("descrizione"));
                product.setAutore(request.getParameter("autore"));
                product.setEditore(request.getParameter("editore"));
                product.setIsbn(request.getParameter("isbn"));
                product.setQuantita(Integer.parseInt(request.getParameter("quantita")));
                product.setIva(Integer.parseInt(request.getParameter("iva")));
                product.setImage(fileName);

                String imagine_alt = "Copertina del volume di " + product.getTitolo();
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

                if (categorieSelezionate != null) {
                    for (String cs : categorieSelezionate) {
                        assert categorie != null;
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
            }
             if(!request.getParameter("action").equals("add"))
            {
                product.setID(Integer.parseInt(request.getParameter("id")));
            }


                ProductDAO productDao = new ProductDAO();
                try {
                    if (request.getParameter("action").equals("modifica") || request.getParameter("action").equals("delete"))
                    {

                        productDao.doDelete(product.getID());

                    }
                    if(!request.getParameter("action").equals("delete")) {

                        productDao.doSave(product);
                    }
                } catch (SQLException e) {
                    errore = true;



                }

                if (!errore) {
                    session.setAttribute("success", request.getParameter("action") +"Avvenuta con successo");
                    response.sendRedirect("index");
                } else {
                    String error = "errore, ritenta.";
                    session.setAttribute("error", error);
                    response.sendRedirect("AddProdotto.jsp");
                }
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
