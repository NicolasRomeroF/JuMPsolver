using JuMP
using GLPK

model_p1 = Model(with_optimizer(GLPK.Optimizer))
@variable(model_p1, x[1:6] >= 0)

for i = 1:6
    @constraint(model_p1, 5000 <= x[i] <= 40000)
end

@constraint(model_p1, x[1] + x[2] + x[3] <= 30000)
@constraint(model_p1, x[1] + x[3] + x[5] + x[6] >= 50000)
@constraint(model_p1, x[1] + x[2] + x[3] + x[4] + x[5] + x[6] <= 100000)

@objective(model_p1, Max, (5.3/100)x[1] + (6.2/100)x[2] + (5.1/100)x[3] + (4.9/100)x[4] + (6.5/100)x[5] + (3.4/100)x[6])

optimize!(model_p1)

print("La solucion optima es: $(JuMP.objective_value(model_p1))\nPara los siguientes valores: $(JuMP.value.(x))\n-----\n")
