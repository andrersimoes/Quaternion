export dcm, from_dcm

"""
    dcm( sys1, sys2 )

Return the Directon Cosine Matrix from coordinate system 1 to coordinate 
system 2. Both sys1 and sys2 are 3x3 matrices. Where:

    sys#[1,:] == x-axis direction
    sys#[2,:] == y-axis direction
    sys#[3,:] == z-axis direction

"""
function dcm( sys1::Array{Float64,2}, sys2::Array{Float64,2} )

    cm = Array{Float64,2}(undef,3,3)
    for i=1:3
        for j=1:3
            cm[i,j] = sum( sys1[i,:] .* sys2[j,:])
        end
    end
    cm
end

"""
    from_dcm( c )
Return a quaternion equivalent to the Direction Cossine Matrix (DCM) c
"""
# vide http://sites.poli.usp.br/p/eduardo.cabral/Preliminares%20Matem%C3%A1ticos.pdf
function from_dcm( c::Array{Float64,2} )

    w = 0.5 * sqrt( c[1,1] + c[2,2] + c[3,3] + 1 )

    # quantas possibilidades de w ser 0 ?
    # c[1,1] = 0 c[2,2] = 0 c[3,3] = -1
    # c[1,1] = 0 c[2,2] = -1 c[3,3] = 0
    # c[1,1] = -1  c[2,2] = 0 c[3,3] = 0
    # ok c[1,1] = 1 c[2,2] = -1 c[3,3] = -1
    # ok c[1,1] = -1 c[2,2] = 1 c[3,3] = -1
    # ok c[1,1] = -1 c[2,2] = -1 c[3,3] = 1
    
    if w != 0
        Quat( w,
         0.5 * sign( c[3,2] - c[2,3] ) * sqrt( +c[1,1] - c[2,2] - c[3,3] + 1 ),
         0.5 * sign( c[1,3] - c[3,1] ) * sqrt( -c[1,1] + c[2,2] - c[3,3] + 1 ),
         0.5 * sign( c[2,1] - c[1,2] ) * sqrt( -c[1,1] - c[2,2] + c[3,3] + 1 ) 
        )
    else
        if c[2,2] == c[3,3] == -1 && c[1,1] == 1
            Quat( 0, 1, 0, 0 )
        elseif c[1,1] == c[3,3] == -1 && c[2,2] == 1
            Quat( 0, 0, 1, 0 )
        elseif c[1,1] == c[2,2] == -1 && c[3,3] == 1
            Quat( 0, 0, 0, 1 )
        elseif c[1,1] == -1 && c[2,2] == c[3,3] == 0
            if c[2,3] == c[3,2] == 1
                Quat( 0, 0, -sqrt(2)/2, -sqrt(2)/2 )
            elseif c[2,3] == c[3,2] == -1
                Quat( 0, 0, -sqrt(2)/2, sqrt(2)/2 )
            else
                throw( "error" )
            end
        elseif c[2,2] == -1 && c[1,1] == c[3,3] == 0
            if c[1,3] == c[3,1] == -1
                Quat( 0, -sqrt(2)/2, 0, -sqrt(2)/2 )
            elseif c[1,3] == c[3,1] == -1
                Quat( 0, sqrt(2)/2, 0, -sqrt(2)/2 )
            else
                throw( "error" )
            end
        elseif c[3,3] == -1 && c[1,1] == c[2,2] == 0
            if c[1,2] == c[2,1] == 1
                Quat( 0, sqrt(2)/2, 0, sqrt(2,2) )
            elseif c[1,2] == c[2,1] == -1
                Quat( 0, sqrt(2)/2, 0, -sqrt(2,2) )
            else
                throw( "error" )
            end
        end
    end
end
