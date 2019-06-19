using JuMP
using GLPK

model_p2 = Model(with_optimizer(GLPK.Optimizer))
@variable(model_p2, x[1:7] >= 0)

@constraint(model_p2, 0.025x[1] + 0.03x[2] >= sum(0.002x[i] for i=1:7))
@constraint(model_p2, 0.003x[3] + 0.9x[4] + 0.96x[5] + 0.004x[6] + 0.006x[7] >= sum(0.004x[i] for i=1:7))
@constraint(model_p2, 0.013x[1] + 0.008x[2] + 0.04x[5] + 0.012x[6] >= sum(0.012x[i] for i=1:7))
@constraint(model_p2, 0.025x[1] + 0.03x[2] <= sum(0.03x[i] for i=1:7))
@constraint(model_p2, 0.003x[3] + 0.9x[4] + 0.96x[5] + 0.004x[6] + 0.006x[7] <= sum(0.006x[i] for i=1:7))
@constraint(model_p2, 0.013x[1] + 0.008x[2] + 0.004x[5] + 0.012x[6] <= sum(0.0165x[i] for i=1:7))

@constraint(model_p2, 0 <= x[1] <= 400)
@constraint(model_p2, 0 <= x[2] <= 300)
@constraint(model_p2, 0 <= x[3] <= 600)
@constraint(model_p2, 0 <= x[4] <= 500)
@constraint(model_p2, 0 <= x[5] <= 200)
@constraint(model_p2, 0 <= x[6] <= 300)
@constraint(model_p2, 0 <= x[7] <= 250)
@constraint(model_p2, sum(x[i] for i=1:7) == 500)

@objective(model_p2, Min, 200x[1] + 250x[2] + 150x[3] + 220x[4] + 240x[5] +200x[6] + 165x[7])

JuMP.optimize!(model_p2)

print("La solucion optima es: $(JuMP.objective_value(model_p2))\nPara los siguientes valores: $(JuMP.value.(x))\n-----\n")
