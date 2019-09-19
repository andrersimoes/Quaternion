export norm, normalize
import Base.-, Base.*, Base.^, Base.==, Base.!=, Base.conj, 
    LinearAlgebra.adjoint

"""
    Quats.conj(q)

Return the conjugate of quaternion q.

#Example
```jldoctest
julia> a = Quat( sqrt(2)/2,sqrt(2)/2,0,0)
Quat( 0.7071067811865476 + 0.7071067811865476i )


julia> conj(a)
Quat( 0.7071067811865476 - 0.7071067811865476i )
```
"""
function conj( q::Quat )
    Quat( q.w, -q.x, -q.y, -q.z )
end

"""
    Quats.norm(q)

Return the norm of quaternion q.

    |q| = sqrt( w² + x² + y² + z² )
"""
function norm( q::Quat )
    sqrt( q.w*q.w + q.x*q.x + q.y*q.y + q.z*q.z )
end

"""
    Quats.normalize(q)
Returns a normalized copy of quaternion q where

    normalize( q ) =    q
                    ___________
                     norm( q )
"""
function normalize( q::Quat )
    n = norm(q)
    ( n > 0 ) ?  Quat( q.w / n, q.x / n, q.y / n, q.z / n ) : q 
end

adjoint( q::Quat ) = conj( q )
*( k::Int64, q::Quat ) = Quat( q.w*k, q.x*k, q.y*k, q.z*k )
*( k::Float64, q::Quat ) = Quat( q.w*k, q.x*k, q.y*k, q.z*k )
*( q::Quat, k::Int64 ) = Quat( q.w*k, q.x*k, q.y*k, q.z*k )
*( q::Quat, k::Float64 ) = Quat( q.w*k, q.x*k, q.y*k, q.z*k )
function *( q1::Quat, q2::Quat )
    Quat(
         q1.w*q2.w - q1.x*q2.x - q1.y*q2.y - q1.z * q2.z,
         q1.w*q2.x + q2.w*q1.x + q1.y*q2.z - q1.z*q2.y,
         q1.w*q2.y + q2.w*q1.y + q1.z*q2.x - q1.x*q2.z,
         q1.w*q2.z + q2.w*q1.z + q1.x*q2.y - q1.y*q2.x
        )
end

-( q::Quat ) = Quat( -q.w, -q.x, -q.y, -q.z )
-( q1::Quat, q2::Quat ) = Quat( q1.w-q2.w, q1.x-q2.x, q1.y-q2.y, q1.z-q2.z )

function ^( q::Quat, n::Int64 )
    r=Quat(1,0,0,0)
    if n > 0 
        while n > 0
            r = r*q
            n-=1
        end
    end
    r
end

function ==(q1::Quat, q2::Quat )
    if q1.w != q2.w || q1.x != q2.x || q1.y != q2.y || q1.z != q2.z
        return false
    else
        return true
    end
end

function !=(q1::Quat, q2::Quat )
    if q1.w != q2.w || q1.x != q2.x || q1.y != q2.y || q1.z != q2.z
        return true
    else
        return false
    end
end

