using JuMP
using GLPK

model_p3 = Model(with_optimizer(GLPK.Optimizer))
@variable(model_p3, x[1:18], binary=true)

for i=9:14
    for j=1:3
        @constraint(model_p3, x[i] <= x[j+i-9])
    end
end

for i=15:18
    for j=1:3
        @constraint(model_p3, x[i] <= x[j+i-7])
    end
end

@objective(model_p3, Max, 10000((200 - 100)x[1] + (-100)x[2] + (-100)x[3] + (-100)x[4] + (-100)x[5] +
                         (-100)x[6] + (300 -100)x[7] + (-100)x[8] + (-1000)x[9] + (500 -200)x[10] +
                        (-200)x[11] + (200-200)x[12] + (-200)x[13] + (-1000)x[14] + (-1000)x[15] +
                        (-1000)x[16] + (1000-300)x[17] + (1200-1000)x[18]))
                        
JuMP.optimize!(model_p3)

print("La solucion optima es: $(JuMP.objective_value(model_p3))\nPara los siguientes valores: $(JuMP.value.(x))\n-----\n")
