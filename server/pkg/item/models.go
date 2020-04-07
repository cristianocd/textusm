// Code generated by github.com/99designs/gqlgen, DO NOT EDIT.

package item

import (
	"fmt"
	"io"
	"strconv"
	"time"
)

type InputItem struct {
	ID         *string `json:"id"`
	Title      string  `json:"title"`
	Text       string  `json:"text"`
	Thumbnail  *string `json:"thumbnail"`
	Diagram    Diagram `json:"diagram"`
	IsPublic   bool    `json:"isPublic"`
	IsBookmark bool    `json:"isBookmark"`
}

type Item struct {
	ID         string    `json:"id"`
	Title      string    `json:"title"`
	Text       string    `json:"text"`
	Thumbnail  *string   `json:"thumbnail"`
	Diagram    Diagram   `json:"diagram"`
	IsPublic   bool      `json:"isPublic"`
	IsBookmark bool      `json:"isBookmark"`
	CreatedAt  time.Time `json:"createdAt"`
	UpdatedAt  time.Time `json:"updatedAt"`
}

type Diagram string

const (
	DiagramUserStoryMap        Diagram = "USER_STORY_MAP"
	DiagramOpportunityCanvas   Diagram = "OPPORTUNITY_CANVAS"
	DiagramBusinessModelCanvas Diagram = "BUSINESS_MODEL_CANVAS"
	DiagramFourls              Diagram = "FOURLS"
	DiagramStartStopContinue   Diagram = "START_STOP_CONTINUE"
	DiagramKpt                 Diagram = "KPT"
	DiagramUserPersona         Diagram = "USER_PERSONA"
	DiagramMarkdown            Diagram = "MARKDOWN"
	DiagramMindMap             Diagram = "MIND_MAP"
	DiagramEmpathyMap          Diagram = "EMPATHY_MAP"
	DiagramCustomerJourneyMap  Diagram = "CUSTOMER_JOURNEY_MAP"
	DiagramSiteMap             Diagram = "SITE_MAP"
	DiagramGanttChart          Diagram = "GANTT_CHART"
	DiagramImpactMap           Diagram = "IMPACT_MAP"
	DiagramErDiagram           Diagram = "ER_DIAGRAM"
	DiagramKanban              Diagram = "KANBAN"
)

var AllDiagram = []Diagram{
	DiagramUserStoryMap,
	DiagramOpportunityCanvas,
	DiagramBusinessModelCanvas,
	DiagramFourls,
	DiagramStartStopContinue,
	DiagramKpt,
	DiagramUserPersona,
	DiagramMarkdown,
	DiagramMindMap,
	DiagramEmpathyMap,
	DiagramCustomerJourneyMap,
	DiagramSiteMap,
	DiagramGanttChart,
	DiagramImpactMap,
	DiagramErDiagram,
	DiagramKanban,
}

func (e Diagram) IsValid() bool {
	switch e {
	case DiagramUserStoryMap, DiagramOpportunityCanvas, DiagramBusinessModelCanvas, DiagramFourls, DiagramStartStopContinue, DiagramKpt, DiagramUserPersona, DiagramMarkdown, DiagramMindMap, DiagramEmpathyMap, DiagramCustomerJourneyMap, DiagramSiteMap, DiagramGanttChart, DiagramImpactMap, DiagramErDiagram, DiagramKanban:
		return true
	}
	return false
}

func (e Diagram) String() string {
	return string(e)
}

func (e *Diagram) UnmarshalGQL(v interface{}) error {
	str, ok := v.(string)
	if !ok {
		return fmt.Errorf("enums must be strings")
	}

	*e = Diagram(str)
	if !e.IsValid() {
		return fmt.Errorf("%s is not a valid Diagram", str)
	}
	return nil
}

func (e Diagram) MarshalGQL(w io.Writer) {
	fmt.Fprint(w, strconv.Quote(e.String()))
}
