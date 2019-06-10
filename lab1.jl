using JuMP
using Cbc

lpModel = Model(with_optimizer(Cbc.Optimizer))
@variable(lpModel, x[1:6] >= 0)


@constraint(lpModel, 5000 <= x[1] <= 40000)
@constraint(lpModel, 5000 <= x[2] <= 40000)
@constraint(lpModel, 5000 <= x[3] <= 40000)
@constraint(lpModel, 5000 <= x[4] <= 40000)
@constraint(lpModel, 5000 <= x[5] <= 40000)
@constraint(lpModel, 5000 <= x[6] <= 40000)

@constraint(lpModel, x[1] + x[2] + x[3] <= 30000)
@constraint(lpModel, x[1] + x[3] + x[5] + x[6] <= 50000)
@constraint(lpModel, x[1] + x[2] + x[3] + x[4] + x[5] + x[6] <= 100000)

@objective(lpModel, Max, (5.3/100)x[1] + (6.2/100)x[2] + (5.1/100)x[3] + (4.9/100)x[4] + (6.5/100)x[5] + (3.4/100)x[6])

JuMP.optimize!(lpModel)

println("Results; $(JuMP.value.(x))")