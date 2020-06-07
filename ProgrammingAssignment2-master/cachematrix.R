## The two functions below create a special "matrix object  
## that can cache its inverse matrix. Caching the inverse 
## saves computing time.

## This is a list containing a function to 
## set and get the value of a matrix
## set and get the inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
  matrixinverse <- NULL
  set <- function(y){
    x <<- y
    matrixinverse <- NULL
  }
  get <- function() x
  setinverse <- function(inverse) matrixinverse <<- inverse
  getinverse <- function() matrixinverse
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## This computes the inverse of a matrix defined above.
## First it looks in the cache for already computed inverse matrix.
## Inverse matrix from the cache is returned if available.
## Otherwise it compute the inverse. 

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  matrixinverse <- x$getinverse()
  if (!is.null(matrixinverse)) {
    message("getting cached data")
    return(matrixinverse)
  }
  inputmatrix <- x$get()
  matrixinverse <- solve(inputmatrix, ...)
  x$setinverse(matrixinverse)
  matrixinverse
}
