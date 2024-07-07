// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

//= require jquery3
//= require popper
//= require bootstrap
//= require slick-carousel/slick/slick
//= require_tree .

/*
document.addEventListener('DOMContentLoaded', (event) => {
  var setupButton = document.getElementById('setupButton');
  var popup = document.getElementById('popup');
  var closePopup = document.getElementById('closePopup');

  setupButton.addEventListener('click', function(event) {
    event.preventDefault(); // Prevent the default behavior of the link

    popup.style.display = "block";
  });

  closePopup.onclick = function() {
    popup.style.display = "none";
  }

  window.onclick = function(event) {
    if (event.target == popup) {
      popup.style.display = "none";
    }
  }
});
*/



