using JuMP
using GLPK

model_p4 = Model(with_optimizer(GLPK.Optimizer))
@variable(model_p4, y[1:7], binary=true)
@variable(model_p4, x[1:7,1:7], binary=true)

for i=1:7
    @constraint(model_p4, sum(x[i,j] for j=1:7) == 1)
end

for i=1:7
    for j=1:7
        @constraint(model_p4, x[i,j] - y[j] <= 0)
    end
end

vertices = [[2, 3, 4, 7],[3,4,5,7],[6,7],[5,6],[6],[7]]

for j=1:6
    for k in vertices[j]
        for i=1:7
            @constraint(model_p4, x[j,i] + x[k,i] <= 1)
        end
    end
end

@objective(model_p4, Min, sum(y[i] for i=1:7))

JuMP.optimize!(model_p4)


print("La solucion optima es: $(JuMP.objective_value(model_p4))\nPara los siguientes valores de y: $(JuMP.value.(y))\nPara los siguientes valores de x: $(JuMP.value.(x))\n-----\n")
