import 'package:flutter/material.dart';
import 'package:gamraka/screens/orders/models/order_model.dart';

import '../../core/app_colors.dart';

class TrackOrderScreen extends StatelessWidget {
  final DateTime createdAt;
  final DateTime estimatedDeliveryDate;
  final OrderModel order;

  const TrackOrderScreen({
    super.key,
    required this.createdAt,
    required this.estimatedDeliveryDate,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final totalDuration = estimatedDeliveryDate.difference(createdAt).inSeconds;
    final elapsed = now.difference(createdAt).inSeconds;

    double progress = elapsed / totalDuration;
    progress = progress.clamp(0.0, 1.0);

    final remaining = estimatedDeliveryDate.difference(now);

    return Scaffold(
      appBar: AppBar(title: const Text('Track Order'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(Icons.airlines, size: 80, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              'Your order is ${order.status}!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),

            // Progress Bar with Label
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Progress'),
                Text('${(progress * 100).toStringAsFixed(0)}%'),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                progress >= 1.0 ? Colors.red : Colors.green,
              ),
              minHeight: 10,
            ),

            const SizedBox(height: 24),

            // Info Cards
            InfoTile(
              title: 'Created At',
              subtitle:
                  "${createdAt.year}-${createdAt.month}-${createdAt.day} ${createdAt.hour}:${createdAt.minute} ${createdAt.hour >= 12 ? "PM" : "AM"}",
              icon: Icons.access_time_filled,
            ),
            InfoTile(
              title: 'Estimated Delivery',
              subtitle:
                  "${estimatedDeliveryDate.year}-${estimatedDeliveryDate.month}-${estimatedDeliveryDate.day} ${estimatedDeliveryDate.hour}:${estimatedDeliveryDate.minute} ${estimatedDeliveryDate.hour >= 12 ? "PM" : "AM"}",

              icon: Icons.event_available,
            ),
            InfoTile(
              title: 'Time Remaining',
              subtitle:
                  remaining.isNegative
                      ? 'Delivery overdue'
                      : '${remaining.inHours} hrs ${remaining.inMinutes % 60} min',
              icon: Icons.timer,
            ),

            InfoTile(
              title: 'Shipping Info',
              subtitle: 'From : ${order.from}\nTo : ${order.to}',
              icon: Icons.location_pin,
            ),

            InfoTile(
              title: 'Item Info',
              subtitle:
                  '${order.itemName}\n${order.category.name}\n${order.itemPrice} EGP',
              icon: Icons.info,
            ),

            InfoTile(
              title: 'Payment Info',
              subtitle:
                  '${order.methodType}\nTaxes : ${order.taxes} EGP\nShipping Cost : ${order.shippingCost} EGP\nTotal : ${order.total} EGP',
              icon: Icons.monetization_on,
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const InfoTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
