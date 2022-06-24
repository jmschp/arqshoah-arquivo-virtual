# frozen_string_literal: true

module GetRegistrationName
  def get_registration_name(record)
    case record
    when Archive
      "RG-ARQ"
    when Book
      "RG-BBG"
    #  when Education
    # "RG-EDU"
    when Iconography
      "RG-ICO"
    #  when Patrimony
    #  "RG-PAT"
    when Savior
      "RG-JUS"
    when Newspaper
      "RG-HEM"
    when Survivor
      "RG-TES"
    end
  end
end
