package net.mullvad.mullvadvpn.compose.component

import androidx.annotation.DrawableRes
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.colorResource
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import net.mullvad.mullvadvpn.R

@Composable
fun ListItem(
    text: String,
    isLoading: Boolean,
    @DrawableRes iconResourceId: Int? = null,
    onClick: () -> Unit
) {
    val itemColor = colorResource(id = R.color.blue)

    Box(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 1.dp)
            .height(50.dp)
            .background(itemColor),
    ) {
        Text(
            text = text,
            fontSize = 18.sp,
            color = Color.White,
            modifier = Modifier
                .padding(
                    horizontal = 16.dp
                )
                .align(Alignment.CenterStart)
        )

        Box(
            modifier = Modifier
                .align(Alignment.CenterEnd)
                .padding(horizontal = 12.dp)
        ) {
            if (isLoading) {
                CircularProgressIndicator(
                    strokeWidth = 3.dp,
                    color = Color.White,
                    modifier = Modifier
                        .height(24.dp)
                        .width(24.dp)
                )
            } else if (iconResourceId != null) {
                Image(
                    painter = painterResource(id = iconResourceId),
                    contentDescription = "Remove",
                    modifier = Modifier
                        .align(Alignment.CenterEnd)
                        .clickable { onClick() }
                )
            }
        }
    }
}
