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
  const searchForm = document.getElementById('search-form');
  const searchInput = document.getElementById('search-input');
  const voiceButton = document.getElementById('voice-button');

  const confirmButton = document.getElementById('confirm-button');
  const confirmationMessage = document.getElementById('confirmation-message');
  const modal = document.getElementById('confirmation-modal');
  const closeButton = document.querySelector('.close-button');

  const searchContainer = document.querySelector('.search-container');


  if ('webkitSpeechRecognition' in window) {
    const recognition = new webkitSpeechRecognition();
    recognition.continuous = false;
    recognition.interimResults = false;
    recognition.lang = 'en-US';

    voiceButton.addEventListener('click', () => {
      recognition.start();
      voiceButton.classList.add('recording');
    });

    recognition.onresult = (event) => {
      const transcript = event.results[0][0].transcript;
      searchInput.value = transcript;
      voiceButton.classList.remove('recording');
    };

    recognition.onerror = (event) => {
      console.error(event.error);
      voiceButton.classList.remove('recording');
    };
  } else {
    console.warn('Speech recognition not supported in this browser.');
  }
  
  searchIcon.addEventListener('click', (event) => {
    event.preventDefault();
    searchForm.dispatchEvent(new Event('submit'));
  });

  searchForm.addEventListener('submit', (event) => {
    event.preventDefault();
    const query = searchInput.value;
    console.log('Query:', query);

    const match1 = query.match(/(\w+)\s(\w+)\s(\d+)/i); // Match format like "pay Nicole 100"
    const match2 = query.match(/(\w+)\s(\d+)\s(to|for)\s(\w+)/i); // Match format like "give 100 to Nicole"

    let action, name, amount;
    if (match1) {
      action = match1[1];
      name = match1[2];
      amount = match1[3];
    } else if (match2) {
      action = match2[1];
      amount = match2[2];
      name = match2[4];
    }

    if (action && name && amount) {
      console.log('Action:', action, 'Name:', name, 'Amount:', amount);
      confirmationMessage.textContent = `This action will bring you to the paynow page. Are you sure you want to paynow ${name} ${amount} dollars?`;
      modal.style.display = 'block';
      darkOverlay.style.display = 'block';
      console.log('Modal displayed');
      console.log('Overlay displayed');
    } else {
      searchForm.submit();
    }
  });

  // Close the modal when the close button is clicked
  closeButton.onclick = () => {
    modal.style.display = 'none';
    darkOverlay.style.display = 'none';
    console.log('Modal closed');
  };

  // Close the modal when clicking outside of it
  window.onclick = (event) => {
    if (event.target == darkOverlay) {
      modal.style.display = 'none';
      darkOverlay.style.display = 'none';
      console.log('Modal closed by clicking outside');
    }
  };

  // Confirm button click event
  confirmButton.addEventListener('click', () => {
    console.log('Confirm button clicked');
    const query = searchInput.value;
    window.location.href = `/search_suggestions?path=${encodeURIComponent(query)}`;
  });
});
