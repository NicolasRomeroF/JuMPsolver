using JuMP
using Cbc

lpModel = Model(with_optimizer(Cbc.Optimizer))
@variable(lpModel, x[1:7] >= 0)

@constraint(lpModel, 0.025x[1] + 0.03x[2] >= 0.02(x[1] + x[2] + x[3] + x[4] + x[5] + x[6] + x[7]))
@constraint(lpModel, 0.003x[3] + 0.9x[4] + 0.96x[5] + 0.004x[6] + 0.006x[7] >= 0.004(x[1] + x[2] + x[3] + x[4] + x[5] + x[6] + x[7]))
@constraint(lpModel, 0.013x[1] + 0.008x[2] + 0.04x[5] + 0.012x[6] >= 0.012(x[1] + x[2] + x[3] + x[4] + x[5] + x[6] + x[7]))
@constraint(lpModel, 0.025x[1] + 0.03x[2] <= 0.03(x[1] + x[2] + x[3] + x[4] + x[5] + x[6] + x[7]))
@constraint(lpModel, 0.003x[3] + 0.9x[4] + 0.96x[5] + 0.004x[6] + 0.006x[7] <= 0.006(x[1] + x[2] + x[3] + x[4] + x[5] + x[6] + x[7]))
@constraint(lpModel, 0.013x[1] + 0.008x[2] + 0.004x[5] + 0.012x[6] <= 0.0165(x[1] + x[2] + x[3] + x[4] + x[5] + x[6] + x[7]))

@constraint(lpModel, 0 <= x[1] <= 400)
@constraint(lpModel, 0 <= x[2] <= 300)
@constraint(lpModel, 0 <= x[3] <= 600)
@constraint(lpModel, 0 <= x[4] <= 500)
@constraint(lpModel, 0 <= x[5] <= 200)
@constraint(lpModel, 0 <= x[6] <= 300)
@constraint(lpModel, 0 <= x[7] <= 250)
@constraint(lpModel, x[1] + x[2] + x[3] + x[4] + x[5] + x[6] + x[7] == 500)

@objective(lpModel, Min, 200x[1] + 250x[2] + 150x[3] + 220x[4] + 240x[5] +200x[6] + 165x[7])

JuMP.optimize!(lpModel)

println("Results; $(JuMP.value.(x))")