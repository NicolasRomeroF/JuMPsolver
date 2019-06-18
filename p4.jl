using JuMP
using Cbc

lpModel = Model(with_optimizer(Cbc.Optimizer))
@variable(lpModel, y[1:7], binary=true)
@variable(lpModel, x[1:7,1:7], binary=true)

for i=1:7
    @constraint(lpModel, sum(x[i,j] for j=1:7) == 1)
end

for i=1:7
    for j=1:7
        @constraint(lpModel, x[i,j] - y[j] <= 0)
    end
end

for i=1:7
    @constraint(lpModel, x[1,i] + x[2,i] <= 1)
end

for i=1:7
    @constraint(lpModel, x[1,i] + x[3,i] <= 1)
end

for i=1:7
    @constraint(lpModel, x[1,i] + x[4,i] <= 1)
end

for i=1:7
    @constraint(lpModel, x[1,i] + x[7,i] <= 1)
end

for i=1:7
    @constraint(lpModel, x[2,i] + x[3,i] <= 1)
end

for i=1:7
    @constraint(lpModel, x[2,i] + x[4,i] <= 1)
end

for i=1:7
    @constraint(lpModel, x[2,i] + x[5,i] <= 1)
end

for i=1:7
    @constraint(lpModel, x[2,i] + x[7,i] <= 1)
end

for i=1:7
    @constraint(lpModel, x[3,i] + x[6,i] <= 1)
end

for i=1:7
    @constraint(lpModel, x[3,i] + x[7,i] <= 1)
end

for i=1:7
    @constraint(lpModel, x[4,i] + x[5,i] <= 1)
end

for i=1:7
    @constraint(lpModel, x[4,i] + x[6,i] <= 1)
end

for i=1:7
    @constraint(lpModel, x[5,i] + x[6,i] <= 1)
end

for i=1:7
    @constraint(lpModel, x[6,i] + x[7,i] <= 1)
end

@constraint(lpModel, x[6,1] + x[7,1] <= 1)
@constraint(lpModel, x[6,2] + x[7,2] <= 1)
@constraint(lpModel, x[6,3] + x[7,3] <= 1)
@constraint(lpModel, x[6,4] + x[7,4] <= 1)
@constraint(lpModel, x[6,5] + x[7,5] <= 1)
@constraint(lpModel, x[6,6] + x[7,6] <= 1)
@constraint(lpModel, x[6,7] + x[7,7] <= 1)

@objective(lpModel, Min, sum(y[i] for i=1:7))

JuMP.optimize!(lpModel)
println("Results Y; $(JuMP.value.(y))")
println("Results X; $(JuMP.value.(x))")