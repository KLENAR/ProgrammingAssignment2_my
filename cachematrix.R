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
# It first checks if the matrix has  been changed (dimentions or elements). 
# If so, it stops, gets the message and skips the computation.
# If not,  it checks if the inverse has already been computed. 
# If so, it gets the result and skips the  computation.
# If not, it computes the inverse, sets the value in the cache via
# setinverse function.
# This function assumes that the matrix is always invertible.

ccacheSolve <- function(x, amx=matrix(), ...) {
  data <- x$get()
  if(!isTRUE(all.equal(dim(amx),dim(data)))) {stop("please reset matrix")}
  if(!isTRUE(all.equal(amx,data)))  {stop("please reset matrix")}
     inv <- x$getinverse()
     if(!is.null(inv)) {
       message("getting cached data.")
       return(inv)
     }
     inv <- solve(data)
     x$setinverse(inv)
     inv
}
## Example
## x<-matrix(c(1,2,3,4),2,3)
## > x
##     [,1] [,2]
## [1,]    1    3
## [2,]    2    4
## > mmx<-makeCacheMatrix(x)
## mmx$get()
##     [,1] [,2]
## [1,]    1    3
## [2,]    2    4
## > mmx$getinverse()
## NULL
## > ccacheSolve(mmx,x)
##      [,1] [,2]
##  [1,]   -2  1.5
## [2,]    1 -0.5
## > x<-matrix(c(10,2,3,4),2,2)
## > x
##      [,1] [,2]
##  [1,]   10    3
##  [2,]    2    4
## > ccacheSolve(mmx,x)
## Error in ccacheSolve(mmx, x) : please reset matrix
## > mmx$set(x)
## > mmx$get()
##      [,1] [,2]
##  [1,]   10    3
##  [2,]    2    4
## > ccacheSolve(mmx,x)
##             [,1]        [,2]
##  [1,]  0.11764706 -0.08823529
## v[2,] -0.05882353  0.29411765

