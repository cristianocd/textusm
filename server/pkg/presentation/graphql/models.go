// Code generated by github.com/99designs/gqlgen, DO NOT EDIT.

package graphql

import (
	"github.com/harehare/textusm/pkg/domain/values"
)

type InputColor struct {
	ForegroundColor string `json:"foregroundColor"`
	BackgroundColor string `json:"backgroundColor"`
}

type InputGistItem struct {
	ID         *string         `json:"id"`
	Thumbnail  *string         `json:"thumbnail"`
	Diagram    *values.Diagram `json:"diagram"`
	Title      string          `json:"title"`
	URL        string          `json:"url"`
	IsBookmark bool            `json:"isBookmark"`
}

type InputItem struct {
	ID         *string         `json:"id"`
	Thumbnail  *string         `json:"thumbnail"`
	Diagram    *values.Diagram `json:"diagram"`
	Title      string          `json:"title"`
	Text       string          `json:"text"`
	IsPublic   bool            `json:"isPublic"`
	IsBookmark bool            `json:"isBookmark"`
}

type InputSettings struct {
	StoryColor      *InputColor `json:"storyColor"`
	Scale           *float64    `json:"scale"`
	ZoomControl     *bool       `json:"zoomControl"`
	TextColor       *string     `json:"textColor"`
	ActivityColor   *InputColor `json:"activityColor"`
	TaskColor       *InputColor `json:"taskColor"`
	Toolbar         *bool       `json:"toolbar"`
	LineColor       string      `json:"lineColor"`
	LabelColor      string      `json:"labelColor"`
	BackgroundColor string      `json:"backgroundColor"`
	Font            string      `json:"font"`
	Height          int         `json:"height"`
	Width           int         `json:"width"`
}

type InputShareItem struct {
	ItemID         string   `json:"itemID"`
	ExpSecond      *int     `json:"expSecond"`
	Password       *string  `json:"password"`
	AllowIPList    []string `json:"allowIPList"`
	AllowEmailList []string `json:"allowEmailList"`
}