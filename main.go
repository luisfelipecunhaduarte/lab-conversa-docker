package main

import (
	"net/http"

	"github.com/luisfelipecunhaduarte/lab-conversa-docker/db"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.POST("/ping", func(c *gin.Context) {
		err := db.LogPing()
		if err != nil {
			c.JSON(http.StatusOK, gin.H{
				"message": "Error: DB connection",
			})
		} else {
			c.JSON(http.StatusOK, gin.H{
				"message": "pong",
			})
		}

	})
	r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}
