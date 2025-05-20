document.addEventListener('DOMContentLoaded', function() {
    // Flash message auto-hide after 5 seconds
    const flashMessages = document.querySelectorAll('.flash-message');
    flashMessages.forEach(message => {
        setTimeout(() => {
            message.style.opacity = '0';
            setTimeout(() => {
                message.style.display = 'none';
            }, 500);
        }, 5000);
    });

    // Date input constraints for flight search
    const dateInputs = document.querySelectorAll('input[type="date"]');
    const today = new Date();
    const formattedToday = today.toISOString().split('T')[0];
    
    dateInputs.forEach(input => {
        input.setAttribute('min', formattedToday);
    });

    // Flight search form validation
    const searchForm = document.getElementById('flight-search-form');
    if (searchForm) {
        searchForm.addEventListener('submit', function(e) {
            const source = document.getElementById('source').value;
            const destination = document.getElementById('destination').value;
            const departureDate = document.getElementById('departure_date').value;
            
            if (!source || !destination || !departureDate) {
                e.preventDefault();
                alert('Please fill all required fields');
            }
            
            if (source === destination) {
                e.preventDefault();
                alert('Source and destination cannot be the same');
            }
        });
    }

    // Registration form validation
    const registerForm = document.getElementById('register-form');
    if (registerForm) {
        registerForm.addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm_password').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match');
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long');
            }
        });
    }

    // Booking form calculation
    const bookingForm = document.getElementById('booking-form');
    if (bookingForm) {
        const seatSelect = document.getElementById('seat_count');
        const priceElement = document.getElementById('total_price');
        const basePrice = parseFloat(priceElement.getAttribute('data-base-price'));
        
        seatSelect.addEventListener('change', function() {
            const seatCount = parseInt(this.value);
            const totalPrice = basePrice * seatCount;
            priceElement.textContent = '$' + totalPrice.toFixed(2);
        });
    }

    // Admin flight form validation
    const addFlightForm = document.getElementById('add-flight-form');
    if (addFlightForm) {
        addFlightForm.addEventListener('submit', function(e) {
            const departureTime = new Date(document.getElementById('departure_time').value);
            const arrivalTime = new Date(document.getElementById('arrival_time').value);
            
            if (arrivalTime <= departureTime) {
                e.preventDefault();
                alert('Arrival time must be after departure time');
            }
        });
    }
});

// Autofill return flight fields
const returnFlightButton = document.querySelectorAll('.btn-return-flight');
returnFlightButton.forEach(button => {
    button.addEventListener('click', function() {
        const outboundFlight = this.dataset.outboundFlight; // Get outbound flight data
        const returnFlight = this.dataset.returnFlight; // Get return flight data
        document.getElementById('source').value = outboundFlight.destination; // Autofill source
        document.getElementById('destination').value = outboundFlight.source; // Autofill destination
        document.getElementById('departure_date').value = returnFlight.date; // Autofill return date
    });
});
