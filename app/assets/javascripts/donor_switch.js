function donorSwitch() {
  const donorOrganizationInputId = document.getElementById("donor_organization_id");
  const donorOrganizationInputType = document.getElementById("donor_organization_type");

  const donorPersonInputId = document.getElementById("donor_person_id");
  const donorPersonInputType = document.getElementById("donor_person_type");

  const donorOrganizationTab = document.querySelector("a#ui-id-1");
  const donorPersonTab = document.querySelector("a#ui-id-2");

  if (donorOrganizationTab && donorPersonTab) {
    const donorOrganizationInputSelect = new TomSelect(donorOrganizationInputId, {});
    const donorPersonInputSelect = new TomSelect(donorPersonInputId, {});
    donorOrganizationTab.addEventListener("click", () => {
      donorOrganizationInputId.disabled = false;
      donorOrganizationInputType.disabled = false;
      donorOrganizationInputSelect.enable();

      donorPersonInputId.disabled = true;
      donorPersonInputType.disabled = true;
      donorPersonInputSelect.disabled();
    });
    donorPersonTab.addEventListener("click", () => {
      donorOrganizationInputId.disabled = true;
      donorOrganizationInputType.disabled = true;
      donorOrganizationInputSelect.disable();

      donorPersonInputId.disabled = false;
      donorPersonInputType.disabled = false;
      donorPersonInputSelect.enable();
    });
  }

  if (donorOrganizationInputId && donorOrganizationInputId.disabled) {
    donorPersonTab.click();
  }
}
