using Quaternion,Test, LinearAlgebra

axis = [ [ 1; 0; 0 ] [ 0; 1; 0 ] [ 0; 0; 1 ] ]
error = 1.e-8

@testset "FromDcmToQuat" begin

    @testset "common case" begin
        θ = 30
        dcmr = [ cosd(θ) -sind(θ) 0; 
                sind(θ) cosd(θ)  0;
                0 0 1 ]
        qr = Quat( cosd(θ/2), 0, 0, sind(θ/2) )
        for j=1:3
            local q = Quat( 0, axis[1,j], axis[2,j], axis[3,j] )
            @test sum( (dcmr * axis[:,j]) - get_vector(qr*q*qr') ) < error
        end
    end

    @testset "-1 singularity matrices" begin
        dcm21 = [ 1 0 0 ; 0 0 -1; 0 1 0. ];
        dcm32 = [ 0 0 -1;  0 1 0; 1 0 0. ];
        dcm43 = [ 0 1  0; -1 0 0; 0 0 1. ];

        q21 = from_dcm( dcm21 )
        q32 = from_dcm( dcm32 )
        q43 = from_dcm( dcm43 )

        @testset "x-Axis rotation" begin
            dcmr = dcm21 * dcm32 * dcm32
            qr = from_dcm( dcmr )

            for j=1:3
                local q = Quat( 0, axis[1,j], axis[2,j], axis[3,j] )
                @test sum( (dcmr * axis[:,j]) - get_vector(qr*q*qr') ) < error
            end

            dcmr = dcm32 * dcm32 * dcm21
            qr = from_dcm( dcmr )

            for j=1:3
                local q = Quat( 0, axis[1,j], axis[2,j], axis[3,j] )
                @test sum( (dcmr * axis[:,j]) - get_vector(qr*q*qr') ) < error
            end
        end

        @testset "y-axis rotation" begin
            dcmr = dcm32 * dcm21 * dcm21
            qr = from_dcm( dcmr )

            for j=1:3
                local q = Quat( 0, axis[1,j], axis[2,j], axis[3,j] )
                @test sum( (dcmr * axis[:,j]) - get_vector(qr*q*qr') ) < error
            end

            dcmr = dcm21 * dcm21 * dcm32
            qr = from_dcm( dcmr )

            for j=1:3
                local q = Quat( 0, axis[1,j], axis[2,j], axis[3,j] )
                @test sum( (dcmr * axis[:,j]) - get_vector(qr*q*qr') ) < error
            end
        end

        @testset "z-axis rotation" begin
            dcmr = dcm43 * dcm32 * dcm32
            qr = from_dcm( dcmr )

            for j=1:3
                local q = Quat( 0, axis[1,j], axis[2,j], axis[3,j] )
                @test sum( (dcmr * axis[:,j]) - get_vector(qr*q*qr') ) < error
            end

            dcmr = dcm32 * dcm32 * dcm43
            qr = from_dcm( dcmr )

            for j=1:3
                local q = Quat( 0, axis[1,j], axis[2,j], axis[3,j] )
                @test sum( (dcmr * axis[:,j]) - get_vector(qr*q*qr') ) < error
            end
        end
    end
end
