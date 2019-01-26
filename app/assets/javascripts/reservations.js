document.addEventListener("turbolinks:load", function() {
  $(".rm-reservations__create-button").click(function() {
    $(".rm-reservations__create-button").addClass('hidden');
    $(".rm-reservations__create-form").removeClass('hidden');
  });

  $(".rm-reservations__create-cancel-button").click(function() {
    $(".rm-reservations__create-form").addClass('hidden');
    $(".rm-reservations__create-button").removeClass('hidden');
  });
});