import flatpickr from "flatpickr"
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"


flatpickr(".datepicker", {
          altInput: true,
          minDate: new Date()
          })

// $('.datepicker').flatpickr({ minDate: new Date() });
