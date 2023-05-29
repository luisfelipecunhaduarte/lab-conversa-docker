package db

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
)

func init() {
	getDB()
}

func getDB() *sql.DB {
	user := os.Getenv("DB_USER")
	password := os.Getenv("DB_PASSWORD")
	host := os.Getenv("DB_HOST")
	port := os.Getenv("DB_PORT")
	database := os.Getenv("DB_DATABASE")
	dt, err := sql.Open(
		"mysql",
		fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", user, password, host, port, database),
	)

	if err != nil {
		panic(err)
	}

	return dt
}

func LogPing() error {
	db := getDB()
	defer db.Close()

	_, err := db.Query("INSERT INTO PING(ping_date) VALUES(NOW())")
	if err != nil {
		log.Println(err.Error())
		return err
	}

	return nil
}
