# frozen_string_literal: true

module GetRegistrationName
  def get_registration_name(record)
    case record
    when Archive
      "RG-ARQ"
    #  when Book
    #  "RG-PUB"
    #  when Education
    # "RG-EDU"
    when Iconography
      "RG-ICO"
    #  when Patrimony
    #  "RG-PAT"
    when Savior
      "RG-JUS"
    #  when Press
    #  "RG-HEM"
    when Survivor
      "RG-TES"
    end
  end
end
