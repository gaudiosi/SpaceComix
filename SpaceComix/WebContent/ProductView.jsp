<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    Collection<?> products = (Collection<?>) request.getAttribute("products");
    if(products==null) {
        response.sendRedirect("./product");
        return;
    }

    ProductBean product = (ProductBean) request.getAttribute("product");

    Carrello cart = (Carrello) request.getAttribute("cart");

    %>

<!DOCTYPE html>
<html>

<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.SpaceComix.model.ProductBean,it.SpaceComix.model.Carrello"%>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>

      <h2><strong></strong></h2>
      <a href="product"> List</a>

      <%
            if(products!= null && products.size()!= 0) {
            Iterator<?> it = products.iterator();
            while (it.hasNext()) {
                ProductBean bean = (ProductBean) it.next();


      %>
      <div>
           <div>
               <a href="product?action=delete&id=<%=bean.getID()%>"></a>
               <div>

               </div>
           </div>

      </div>

<%}}%>

</body>
</html>