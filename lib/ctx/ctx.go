package ctx

import (
	"net/http"
	"strings"

	"github.com/micro/go-micro/metadata"
	"golang.org/x/net/context"
)

func FromRequest(r *http.Request) context.Context {
	ctx := context.Background()
	md := make(metadata.Metadata)
	for k, v := range r.Header {
		md[k] = strings.Join(v, ",")
	}
	return metadata.NewContext(ctx, md)
}
