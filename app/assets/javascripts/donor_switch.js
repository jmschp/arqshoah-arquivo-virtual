function donorSwitch() {
  const donorOrganizationInputId = document.getElementById("donor_organization_id");
  const donorOrganizationInputType = document.getElementById("donor_organization_type");
  const donorPersonInputId = document.getElementById("donor_person_id");
  const donorPersonInputType = document.getElementById("donor_person_type");

  const donorOrganizationTab = document.querySelector("a#ui-id-1")
  const donorPersonTab = document.querySelector("a#ui-id-2")

  if (donorOrganizationTab && donorPersonTab) {
    donorOrganizationTab.addEventListener("click", () => {
      donorOrganizationInputId.disabled = false;
      donorOrganizationInputType.disabled = false;
      donorPersonInputId.disabled = true;
      donorPersonInputType.disabled = true;
    });
    donorPersonTab.addEventListener("click", () => {
      donorOrganizationInputId.disabled = true;
      donorOrganizationInputType.disabled = true;
      donorPersonInputId.disabled = false;
      donorPersonInputType.disabled = false;
    });
  }

  if (donorOrganizationInputId && donorOrganizationInputId.disabled) {
    donorPersonTab.click();
  }
}
