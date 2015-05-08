class TermsController < ApplicationController
  before_action :set_term, only: [:show, :edit, :update, :destroy]
  before_action :set_project

  # GET /terms
  # GET /terms.json
  def index
  end

  # GET /terms/1
  # GET /terms/1.json
  def show
  end

  # GET /terms/new
  def new
    @term = Term.new
  end

  # GET /terms/1/edit
  def edit
  end

  # POST /terms
  # POST /terms.json
  def create
    @term = Term.new(term_params)
    @term.project = @project

    # Multiline terms maybe possible for website
    if @project.kind != 1
      terms = @term.title.split( "\n" ).map( &:strip ).reject( &:empty? )

      if terms.length > 1
        terms.each do |t|
          @multi_term = Term.new(term_params)
          @multi_term.title = t
          @multi_term.project = @project
          @multi_term.save!
          @term = @multi_term
        end
      end
    end

    respond_to do |format|
      if @term.save
        format.html { redirect_to project_terms_path(@project), notice: 'Term was successfully created.' }
        format.json { render :show, status: :created, location: @term }
      else
        format.html { render :new }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /terms/1
  # PATCH/PUT /terms/1.json
  def update
    respond_to do |format|
      if @term.update(term_params)
        format.html { redirect_to project_terms_path(@project), notice: 'Term was successfully updated.' }
        format.json { render :show, status: :ok, location: @term }
      else
        format.html { render :edit }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /terms/1
  # DELETE /terms/1.json
  def destroy
    @term.destroy
    respond_to do |format|
      format.html { redirect_to project_terms_path(@project), notice: 'Term was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_term
      @term = Term.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def term_params
      params.require(:term).permit(:title, :project_id, :plural)
    end
end
