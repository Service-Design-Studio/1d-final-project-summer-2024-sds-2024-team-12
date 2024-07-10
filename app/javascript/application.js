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
      popup.style.display = "block";
    });

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




