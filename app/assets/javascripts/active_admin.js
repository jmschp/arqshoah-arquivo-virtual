//= require active_admin/base
//= require tom-select
//= require ./donor_switch
//= require ./tom_select_init_admin

window.addEventListener("load", () => {
  donorSwitch();
  tomSelectInit();
});

$(document).on("has_many_add:after", () => {
  tomSelectInit();
});
