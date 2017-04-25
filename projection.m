function P = projection(M) 

    P = M * inv(M' * M )* M'; 

end