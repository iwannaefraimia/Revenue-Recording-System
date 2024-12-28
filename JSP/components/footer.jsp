<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


		<!-- footer -->
		<footer class="navbar navbar-default navbar-fixed-bottom">
			<div class="container">
				<div class="row">
					<div class="col-xs-12">
						<p class="text-center">
							&copy; Υλοποίηση από ΟΠΑ ΔΕΤ <br>
							Ανάπτυξη & Αρχιτεκτονικές Πληροφοριακών Συστημάτων <br>
							(Ιακωβάκη Θ., Καρυτσιώτη Ι., Κουρουπάκης Σ., Τσάκαλος Γ.)
						</p>
					</div>						
				</div>
			</div>
		</footer>
		<!-- End footer -->
		


		<!-- =================== All javascript at the end of the JSP file, so the pages load faster =================== -->
		<!-- jQuery library -->
		<script src="<%=request.getContextPath()%>/omadiki5/js/jquery.min.js"></script>
		<!-- Bootstrap bundle JavaScript (with popper in) -->
		<script	src="<%=request.getContextPath()%>/omadiki5/js/bootstrap.min.js"></script>


		<script>
			
			
			function openPopup(url) {
			// Get the width of the user's screen
			var screenWidth = window.screen.width;

			// Calculate the width for the popup window (you can adjust the multiplier as needed)
			var popupWidth = Math.floor(screenWidth * 0.5);

			// Set the height and width of the popup window
			var popupFeatures = "width=" + popupWidth + ",height=600";

			// Open the popup window
			window.open(url, "_blank", popupFeatures);
			}


			function closePopup() {
				window.close();
			}


			function goBack() {
				window.history.back();
			}


		</script>
