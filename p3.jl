using JuMP
using Cbc

lpModel = Model(with_optimizer(Cbc.Optimizer))
@variable(lpModel, x[1:18], binary=true)

@constraint(lpModel, x[9] <= x[1])
@constraint(lpModel, x[9] <= x[2])
@constraint(lpModel, x[9] <= x[3])
@constraint(lpModel, x[10] <= x[2])
@constraint(lpModel, x[10] <= x[3])
@constraint(lpModel, x[10] <= x[4])
@constraint(lpModel, x[11] <= x[3])
@constraint(lpModel, x[11] <= x[4])
@constraint(lpModel, x[11] <= x[5])
@constraint(lpModel, x[12] <= x[4])
@constraint(lpModel, x[12] <= x[5])
@constraint(lpModel, x[12] <= x[6])
@constraint(lpModel, x[13] <= x[5])
@constraint(lpModel, x[13] <= x[6])
@constraint(lpModel, x[13] <= x[7])
@constraint(lpModel, x[14] <= x[6])
@constraint(lpModel, x[14] <= x[7])
@constraint(lpModel, x[14] <= x[8])

@constraint(lpModel, x[15] <= x[9])
@constraint(lpModel, x[15] <= x[10])
@constraint(lpModel, x[15] <= x[11])
@constraint(lpModel, x[16] <= x[10])
@constraint(lpModel, x[16] <= x[11])
@constraint(lpModel, x[16] <= x[12])
@constraint(lpModel, x[17] <= x[11])
@constraint(lpModel, x[17] <= x[12])
@constraint(lpModel, x[17] <= x[13])
@constraint(lpModel, x[18] <= x[12])
@constraint(lpModel, x[18] <= x[13])
@constraint(lpModel, x[18] <= x[14])

@objective(lpModel, Max, (200 - 100)x[1] + (-100)x[2] + (-100)x[3] + (-100)x[4] + (-100)x[5] +
                         (-100)x[6] + (200 -100)x[7] + (-100)x[8] + (-1000)x[9] + (500 -200)x[10] +
                        (-200)x[11] + (200-200)x[12] + (-200)x[13] + (-1000)x[14] + (-1000)x[15] +
                        (-1000)x[16] + (1000-300)x[17] + (1200-1000)x[18])
                        
JuMP.optimize!(lpModel)

println("Results; $(JuMP.value.(x))")
