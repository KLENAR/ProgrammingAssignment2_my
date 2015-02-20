# Caching the inverse of a matrix
#
# makeCacheMatrix creates a list containing functions to
# 1. set the value of the matrix
# 2. get the value of the matrix
# 3. set the value of inverse of the matrix
# 4. get the value of inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) inv <<- inverse
  getinverse <- function() inv
  list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}


# The following function returns the inverse of the matrix. 
# This function assumes that the matrix is always invertible 
# If matrix changes it needs e.g. recache it   before call this function

ccacheSolve <- function(x,...) {
    inv<-x$getinverse()
    if(!is.null(inv)) {
       # getting cached data
       return(inv)
     }
    # solving inverse
     data <- x$get()
     inv <- solve(data)
     x$setinverse(inv)
     inv
}


