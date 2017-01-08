module ResourcesHelper

  def unread_flag(resource)
    find_resourcery(resource).read ? "" : ' - <span class="bluish">New!</span>'
  end

  def resource_shared_date(resource)
    find_resourcery(resource).created_at.strftime('%D')
  end

  def find_resourcery(resource)
    Resourcery.find_by(resource_id: resource.id, prep_id: @prep.id)
  end

  def resource_shared_with_prep?(resource)
    resource.preps.include? @prep
  end

  def new_resource_count
    @new_resource_count = @prep.resourceries.where("read = ?", false).count
    @new_resource_count > 0 ? "Resources (#{@new_resource_count})" : "Resources"
  end

end
