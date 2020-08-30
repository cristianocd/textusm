import { CanvasItem, toString as canvasItemToString } from "./CancasItem";

type UserPersona = {
  name: "UserPersona";
  url: UrlItem;
  whoAmI: CanvasItem;
  item1: CanvasItem;
  item2: CanvasItem;
  item3: CanvasItem;
  item4: CanvasItem;
  item5: CanvasItem;
  item6: CanvasItem;
  item7: CanvasItem;
};

type UrlItem = {
  title: string;
  url: string;
};

function toString(userPersona: UserPersona): string {
  const items = [
    "whoAmI",
    "item1",
    "item2",
    "item3",
    "item4",
    "item5",
    "item6",
    "item7",
  ];

  return `${userPersona.url.title}\n    ${userPersona.url.url}\n${items
    .map((item) => {
      return canvasItemToString(userPersona[item]);
    })
    .join("")}`;
}

export { UserPersona, toString };
