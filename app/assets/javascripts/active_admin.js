//= require active_admin/base
//= require tom-select
//= require ./donor_switch
//= require ./tom_select_init

window.addEventListener("load", () => {
  donorSwitch();
  tomSelectInit();
});
