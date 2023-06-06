class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]

  def index
    @expenses = Expense.all
  end

  def show; end

  def new
    @expense = Expense.new
    @group = current_user.groups.all
  end

  def edit; end

  def create
    @expense = Expense.new(expense_params)
    @expense.author_id = current_user.id

    @group = Group.find(params[:expense][:group_id])

    respond_to do |format|
      if @expense.save

        ExpensesGroup.create(group: @group, expense: @expense)

        format.html do
          redirect_to user_group_path(@group.user, @group), notice: 'Successfully created the transaction'
        end
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: 'Successfully updated the transaction' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to group_path, notice: 'Transaction was successfully deleted }
      format.json { head :no_content }
    end
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :group_id).merge(author_id: current_user.id)
  end
end
