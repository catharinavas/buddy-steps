import flatpickr from "flatpickr"
import "flatpickr/dist/themes/confetti.css" // Note this is important!
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!


flatpickr(".datepicker", {
          enableTime: true,
          altInput: true,
          minDate: new Date()
          })

// $('.datepicker').flatpickr({ minDate: new Date() });
