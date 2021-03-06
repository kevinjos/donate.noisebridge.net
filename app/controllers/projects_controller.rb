class ProjectsController < DonationsController
  def show
    @name = params[:id]
    @project = Project.find(params[:id].to_sym)
    @should_render_partial = template_exists?(@name, _prefixes, true)
  end

  def index
    @project_totals = Charge.project_totals
  end
end
