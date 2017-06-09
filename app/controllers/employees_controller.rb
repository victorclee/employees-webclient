class EmployeesController < ApplicationController
  def index
    # @employees = Employee.new(Unirest.get("#{ ENV["API_HOST"]}/api/v1/employees.json").body)
    @employees = []
    Unirest.get("#{ ENV["API_HOST"]}/api/v1/employees.json").body.each do |employee_hash|
      @employees << Employee.new(employee_hash)
    end
  end

  def new
    
  end
  def create
    employee = Employee.create(
                              first_name: params[:first_name],
                              last_name: params[:last_name],
                              email: params[:email]
                              )
    redirect_to "/employees/#{employee.id}"
  end
  def show
    @employee = Employee.find(params[:id])
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    employee = Employee.find(params[:id])
    employee.update(
                    first_name: params[:first_name],
                    last_name: params[:last_name],
                    email: params[:email]
                    )
    redirect_to "/employees/#{employee.id}"
  end

  def destroy
    employee = Employee.find(params[:id]) 
    employees.destroy
    redirect_to "/employees"
  end










end
