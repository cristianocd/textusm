package share

import (
	"context"

	"github.com/harehare/textusm/pkg/domain/model/item"
	shareModel "github.com/harehare/textusm/pkg/domain/model/share"
)

type ShareRepository interface {
	Find(ctx context.Context, hashKey string) (*item.DiagramItem, *shareModel.Share, error)
	Save(ctx context.Context, hashKey string, item *item.DiagramItem, shareInfo *shareModel.Share) error
	Delete(ctx context.Context, hashKey string) error
}
