package controllers

import (
	"encoding/csv"
	"encoding/json"
	"fmt"
	beego "github.com/beego/beego/v2/server/web"
	_ "github.com/go-redis/redis/v8"
	"mime"
	"net/http"
	"os"
	"os/user"
	"path/filepath"
	"shotstand/models"
	"strconv"
	"strings"
	"time"
)

type ExportController struct {
	beego.Controller
}

func (c *ExportController) Get() {
	flash := beego.ReadFromRequest(&c.Controller)

	c.Data["message"] = flash.Data["notice"]
	c.TplName = "export.tpl"
}

func (c *ExportController) Post() {

	filetype := c.GetString("filetype")
	path := ""

	if filetype == "csv" {
		path = createCSV()
	} else if filetype == "json" {
		path = createJSON()
	}

	flash := beego.NewFlash()
	flash.Notice(fmt.Sprintf("Export %s to %s", filetype, path))
	flash.Store(&c.Controller)

	f, err := os.Open(path)

	p := strings.Split(path, string(filepath.Separator))

	checkError("Cannot open file", err)

	cd := mime.FormatMediaType("attachment", map[string]string{"filename": p[len(p)-1]})

	c.Ctx.ResponseWriter.Header().Set("Content-Disposition", cd)
	c.Ctx.ResponseWriter.Header().Set("Content-Type", "application/octet-stream")

	http.ServeContent(c.Ctx.ResponseWriter, c.Ctx.Request, p[len(p)-1], time.Now(), f)
}

func createCSV() string {

	file, err, path := createFile("csv")
	defer file.Close()

	writer := csv.NewWriter(file)
	defer writer.Flush()

	data := models.GetShotdata()

	var dtpt = []string{"Gruppe", "Anzahl"}
	err = writer.Write(dtpt)
	checkError("Cannot write to file: ", err)

	for _, ct := range data {
		var dtpt = []string{ct.Label, strconv.FormatInt(ct.Y, 10)}
		err := writer.Write(dtpt)
		checkError("Cannot write to file: ", err)
	}

	checkError("Cannot create file: ", err)

	return path
}

func createJSON() string {

	file, err, path := createFile("json")
	defer file.Close()
	checkError("Cannot create file", err)

	data := models.GetShotdata()

	jsonData, _ := json.MarshalIndent(data, "", "  ")

	_, err = file.Write(jsonData)
	checkError("Cannot write to file", err)

	return path
}

func createFile(suffix string) (*os.File, error, string) {

	currentuser, err := user.Current()
	checkError("Cannot get current user: ", err)

	filename := fmt.Sprintf("shotcount-%s.%s", time.Now().Format("02012006_150405"), suffix)
	path := filepath.Join(currentuser.HomeDir, filename)

	file, err := os.Create(path)

	return file, err, path

}

func checkError(message string, err error) {
	if err != nil {
		fmt.Println(message, err)
	}
}
