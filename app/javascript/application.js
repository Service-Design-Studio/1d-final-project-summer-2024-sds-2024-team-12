// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

//= require jquery3
//= require popper
//= require bootstrap
//= require slick-carousel/slick/slick
//= require_tree .


document.addEventListener('DOMContentLoaded', (event) => {
  
  var setupButtons = document.querySelectorAll('[id^="setupButton"]');

  setupButtons.forEach((setupButton, index) => {
    var popup = document.getElementById(`popup${index}`);
    var closePopup = popup.querySelector('.close');
    var scheduleButton = document.getElementById(`scheduleButton${index}`);

    setupButton.addEventListener('click', function(event) {
      event.preventDefault();
      popup.style.display = "block";})
      
  

    closePopup.addEventListener('click', function() {
      popup.style.display = "none";
    });

    window.addEventListener('click', function(event) {
      if (event.target == popup) {
        popup.style.display = "none";
      }
    });

    scheduleButton.addEventListener('click', function(event) {
      // The form will be submitted and the page will navigate to the new URL
      // The pre-filled data is already in the URL params, so no additional JS is needed here
    });
  });
});

document.addEventListener('DOMContentLoaded', (event) => {
  var stopShowingButtons = document.querySelectorAll('.stopShowingButton');

  stopShowingButtons.forEach((stopShowingButton, index) => {
    var carouselItem = document.getElementById(`carouselItem${index}`);
    var carouselIndicators = document.getElementById('carouselIndicators');

    stopShowingButton.addEventListener('click', function() {
      // Remove the carousel item
      carouselItem.remove();
      // Remove the corresponding indicator
      var indicatorToRemove = carouselIndicators.querySelector(`[data-slide-to="${index}"]`);
      if (indicatorToRemove) {
        indicatorToRemove.remove();
      }
      // Update the active indicator if needed
      var activeIndicator = carouselIndicators.querySelector('.active');
      if (activeIndicator) {
        activeIndicator.classList.remove('active');
        if (index > 0) {
          carouselIndicators.children[index - 1].classList.add('active');
        } else {
          carouselIndicators.firstChild.classList.add('active');
        }
      }
      // Optionally, add logic to remember the user preference (e.g., using localStorage, cookies, or sending a request to the server)
      localStorage.setItem(`hideCarouselItem${index}`, 'true');
    });

    if (localStorage.getItem(`hideCarouselItem${index}`) === 'true') {
      carouselItem.style.display = 'none';
      var indicatorToRemove = carouselIndicators.querySelector(`[data-slide-to="${index}"]`);
      if (indicatorToRemove) {
        indicatorToRemove.style.display = 'none';
      }
    }
  });
});





function drawInitialsIcon(canvasId, text) {
  var canvas = document.getElementById(canvasId);
  var ctx = canvas.getContext('2d');
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  ctx.fillStyle = '#007bff'; // Background color
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  ctx.fillStyle = 'white'; // Text color
  ctx.font = 'bold 24px Arial';
  ctx.textAlign = 'center';
  ctx.textBaseline = 'middle';
  ctx.fillText(text, canvas.width / 2, canvas.height / 2);
}

function getInitials(name) {
  return name.split(' ').map(n => n[0]).join('').toUpperCase();
}




document.addEventListener('DOMContentLoaded', function() {
  const form = document.getElementById('transaction-form');
  const errorPopup = document.getElementById('error_popup');
  const errorPopupOkButton = document.getElementById('error_popup-ok-button');
  
  let okButtonClicked = false; // Flag to track OK button click

  // Show the popup if there are validation errors
  form.addEventListener('submit', function(event) {
    const amountField = form.querySelector('input[name="transaction[amount]"]');
    const amount = parseFloat(amountField.value);
    

    if (isNaN(amount) || amount <= 0) {
      event.preventDefault(); // Prevent form submission
      if (!okButtonClicked) { // Show popup only if OK button hasn't been clicked
        errorPopup.classList.remove('hidden');
        console.log('Popup shown:', errorPopup.classList); // Log class list
      }
    } else {
      // If amount is valid and OK button was clicked previously, hide the popup
      errorPopup.classList.add('hidden');
      console.log('Popup hidden:', errorPopup.classList); // Log class list
    }
  });

  // Hide the popup when the OK button is clicked
  errorPopupOkButton.addEventListener('click', function() {
    console.log('OK button clicked');
    errorPopup.classList.add('hidden');
    okButtonClicked = true; // Set flag to true when OK button is clicked
    console.log('Popup hidden:', errorPopup.classList); // Log class list
  });
});
