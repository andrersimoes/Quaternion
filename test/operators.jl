using Quaternion,Test

@testset "Operators" begin
    @testset "Equality" begin
        @test Quat( 1, 2, 3, 4 ) == Quat( 1, 2, 3, 4 ) 
        @test !( Quat( 1, 2, 3, 4 ) == Quat( 1, 2, 3, 1 ) ) 
        @test !( Quat( 1, 2, 3, 4 ) == Quat( 1, 2, 1, 4 ) )
        @test !( Quat( 1, 2, 3, 4 ) == Quat( 1, 1, 3, 4 ) )
        @test !( Quat( 1, 2, 3, 4 ) == Quat( 4, 2, 3, 4 ) )
    end

    @testset "Inequality" begin
        @test Quat( 1, 2, 3, 4 ) != Quat( 1, 2, 3, 1 )
        @test Quat( 1, 2, 3, 4 ) != Quat( 1, 2, 1, 4 )
        @test Quat( 1, 2, 3, 4 ) != Quat( 1, 1, 3, 4 )
        @test Quat( 1, 2, 3, 4 ) != Quat( 4, 2, 3, 4 )
        @test !( Quat( 1, 2, 3, 4 ) != Quat( 1, 2, 3, 4 ) )
    end

    @testset "Conjugate" begin
        @test conj(Quat( 1, 2, 3, 4 )) == Quat( 1, -2, -3, -4 )
        @test Quat( 1, 2, 3, 4 )' == Quat( 1, -2, -3, -4 )
    end

    @testset "Unary" begin
        @test -Quat(1,2,3,4) == Quat(-1,-2,-3,-4)
    end
end
