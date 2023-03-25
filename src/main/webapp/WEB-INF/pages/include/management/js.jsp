<%-- 
    Document   : js
    Created on : Jul 31, 2022, 5:10:39 PM
    Author     : henry
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- plugins:js -->
<script src="<c:url value="/resources-management/vendors/js/vendor.bundle.base.js"/>"/></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<script src="<c:url value="/resources-management/vendors/chart.js/Chart.min.js"/>"/></script>
<script src="<c:url value="/resources-management/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"/>"/></script>
<script src="<c:url value="/resources-management/vendors/progressbar.js/progressbar.min.js"/>"/></script>
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="<c:url value="/resources-management/js/off-canvas.js"/>"/></script>
<script src="<c:url value="/resources-management/js/hoverable-collapse.js"/>"/></script>
<script src="<c:url value="/resources-management/js/template.js"/>"/></script>
<script src="<c:url value="/resources-management/js/settings.js"/>"/></script>
<script src="<c:url value="/resources-management/js/todolist.js"/>"/></script>
<!-- endinject -->
<!-- Custom js for this page-->
<script src="<c:url value="/resources-management/js/jquery.cookie.js"/>"/></script>
<script src="<c:url value="/resources-management/js/dashboard.js"/>"/></script>
<script src="<c:url value="/resources-management/js/Chart.roundedBarCharts.js"/>"/></script>
<script src="<c:url value="/resources-management/js/file-upload.js"/>"/></script>
<script src="<c:url value="/resources-management/js/typeahead.js"/>"/></script>
<script src="<c:url value="/resources-management/js/select2.js"/>"/></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous">
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous">
</script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous">
</script>

<script>
   //time
    function clock() {
        var today = new Date();
        var time = today.getHours() + " : " + today.getMinutes() + " : " + today.getSeconds();
        document.getElementById("time").value = time;
    }
    setInterval("clock()", 1000);
    
    //Back to top
    mybutton = document.getElementById("myBtn");

// When the user scrolls down 20px from the top of the document, show the button
    window.onscroll = function () {
        scrollFunction()
    };

    function scrollFunction() {
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            mybutton.style.display = "block";
        } else {
            mybutton.style.display = "none";
        }
    }

// When the user clicks on the button, scroll to the top of the document
    function topFunction() {
        document.body.scrollTop = 0; // For Safari
        document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
    }
    
//image    
   function showImage(src,target) {
  var fr=new FileReader();
  // when image is loaded, set the src of the image where you want to display it
  fr.onload = function(e) { target.src = this.result; };
  src.addEventListener("change",function() {
    // fill fr with image data    
    fr.readAsDataURL(src.files[0]);
  });
}

var src = document.getElementById("src");
var target = document.getElementById("target");
showImage(src,target);

</script>