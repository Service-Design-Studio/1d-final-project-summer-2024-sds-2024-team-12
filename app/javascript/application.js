// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

//= require jquery3
//= require popper
//= require bootstrap
//= require slick-carousel/slick/slick
//= require_tree .


document.addEventListener('turbo:load', (event) => {
  
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


document.addEventListener("turbo:load", () => {
  const pathInput = document.querySelector('input[name="path"]');
  const suggestionsContainer = document.getElementById('suggestions-container');
  
  const paths = [
    { name: 'Local Transfer Limit', value: 'Local Transfer Limit' },
    // { name: 'Change Limit', value: 'change_limit' }
    // Add more paths as needed
  ];

  pathInput.addEventListener('input', () => {
    const query = pathInput.value.toLowerCase();
    suggestionsContainer.innerHTML = '';

    paths.forEach(path => {
      if (path.name.toLowerCase().includes(query)) {
        const div = document.createElement('div');
        div.textContent = path.name;
        div.classList.add('suggestion-item');
        div.addEventListener('click', () => {
          pathInput.value = path.value;
          suggestionsContainer.innerHTML = '';
        });
        suggestionsContainer.appendChild(div);
      }
    });
  });
});

document.addEventListener("turbo:load", () => {
  const searchIcon = document.getElementById('search-icon');
  const searchInput = document.getElementById('search-input');
  const voiceButton = document.getElementById('voice-button');

  if ('webkitSpeechRecognition' in window) {
    const recognition = new webkitSpeechRecognition();
    recognition.continuous = false;
    recognition.interimResults = false;
    recognition.lang = 'en-US';

    voiceButton.addEventListener('click', () => {
      recognition.start();
    });

    recognition.onresult = (event) => {
      const transcript = event.results[0][0].transcript;
      if (transcript){
      searchInput.value = transcript;
    }
      // processSearchQuery(transcript);
    };

    recognition.onerror = (event) => {
      console.error(event.error);
    };
  } else {
    console.warn('Speech recognition not supported in this browser.');
  }
  
  searchIcon.addEventListener('click', () => {
    searchForm.submit();
  });
});



