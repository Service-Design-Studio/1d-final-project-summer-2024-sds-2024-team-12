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


document.addEventListener('turbo:load', (event) => {
  var stopShowingButtons = document.querySelectorAll('.stopShowingButton');
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
  const noContactModal = document.getElementById('no-contact-modal');
  const noContactMessage = document.getElementById('no-contact-message');
  const closeButton = document.querySelectorAll('.search-close-button');

  const darkOverlay = document.getElementById('dark-overlay');
  const searchContainer = document.querySelector('.search-container');

  let redirectPath = '';

  function expandSearchBar() {
    searchContainer.classList.add('search-bar-expanded');
    darkOverlay.classList.add('active');
  }

  function collapseSearchBar() {
    searchContainer.classList.remove('search-bar-expanded');
    darkOverlay.classList.remove('active');
  }

  searchInput.addEventListener('focus', expandSearchBar);
  searchInput.addEventListener('blur', collapseSearchBar);

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
      console.error('Speech recognition error:', event.error);
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
    let query = searchInput.value.trim();
    console.log('Original Query:', query);

    // Preprocess the query to strip dollar signs and handle decimals
    query = query.replace(/\$/g, '').replace(/,/g, '');
    console.log('Normalized Query:', query);

    const match1 = query.match(/(\w+)\s(\w+)\s(\d+(\.\d+)?)/i); // Match format like "pay Nicole 100" or "pay Nicole 100.50"
    const match2 = query.match(/(\w+)\s(\d+(\.\d+)?)\s(to|for)\s(\w+)/i); // Match format like "give 100 to Nicole" or "give 100.50 to Nicole"

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
      
      // Check if the contact exists in the database
      fetch(`/check_contact?name=${name}`)
        .then(response => response.json())
        .then(data => {
          if (data.exists) {
            confirmationMessage.textContent = `This action will bring you to the paynow page. Are you sure you want to paynow ${name} ${amount} dollars?`;
            redirectPath = `/search_suggestions?path=${encodeURIComponent(query)}`;
            modal.style.display = 'block';
            darkOverlay.style.display = 'block';
          } else {
            noContactMessage.textContent = `This person is not within your existing paynow recipients. Please add the recipient.`;
            noContactModal.style.display = 'block';
            darkOverlay.style.display = 'block';
          }
          console.log('Modal displayed');
          console.log('Overlay displayed');
        })
        .catch(error => {
          console.error('Error:', error);
          searchForm.submit();
        });
    } else {
      searchForm.submit();
    }
  });

  // Close the modal when the close button is clicked
  closeButton.forEach(button => {
    button.onclick = () => {
      modal.style.display = 'none';
      noContactModal.style.display = 'none';
      darkOverlay.style.display = 'none';
      console.log('Modal closed');
    };
  });

  // Close the modal when clicking outside of it
  window.onclick = (event) => {
    if (event.target == darkOverlay) {
      modal.style.display = 'none';
      noContactModal.style.display = 'none';
      darkOverlay.style.display = 'none';
      console.log('Modal closed by clicking outside');
    }
  };

  // Confirm button click event
  confirmButton.addEventListener('click', () => {
    console.log('Confirm button clicked');
    window.location.href = redirectPath;

  });
});

document.addEventListener('turbo:load', function() {
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
