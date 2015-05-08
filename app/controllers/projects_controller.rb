class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects/1/import
  def import
    @project = Project.find(params[:project_id])
    @language = Language.find(params[:language_id])
    content = JSON.parse params[:file].read
    import_terms = params[:import_terms] == "on"

    if @project.kind == 2
      # poeditor style json files, as array, element example:
      #
      #  "term": "bound##panel##points",
      #  "definition": {
      #      "one": "__count__ Punkt",
      #      "other": "__count__ Punkte"
      #  },
      #  "context": "",
      #  "term_plural": "bound##panel##points",
      #  "reference": "",
      #  "comment": ""

      content.each do |entry|
        # try to find the term
        term_title = entry["term"].gsub '##', '.'
        term_plural = !entry["term_plural"].empty?
        term = @project.terms.find_by title: term_title

        # create term if needed
        if import_terms and not term
          term = Term.new title: term_title, project: @project, plural: term_plural
          term.save!
        end

        # import translation
        if term
          translation = @language.translate term

          if term_plural
            translation.title = entry["definition"]["one"]
            translation.title_plural = entry["definition"]["other"]
          else
            translation.title = entry["definition"]
          end

          translation.save!
        end


      end

      redirect_to @project, notice: 'Import erfolgreich'
    else
      redirect_to @project, alert: 'Sorry, das geht so nicht :('
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :kind)
    end
end
