#include "DatagramListener.h"

DatagramListener::DatagramListener(quint16 port, IDataConsumer* consumer)
	: m_port(port)
	, m_consumer(consumer) {}

void DatagramListener::Start() {
	if (m_is_in_progress)
		return;

	m_socket.bind(m_port, QUdpSocket::ShareAddress);
	connect(&m_socket, &QUdpSocket::readyRead, this, &DatagramListener::ProcessDatagrams);
}

void DatagramListener::Stop() {
	m_socket.abort();
	m_is_in_progress = false;
}

void DatagramListener::ProcessDatagrams() {
	m_is_in_progress = true;
	QByteArray datagram;

	while (m_socket.hasPendingDatagrams()) {
		datagram.resize(static_cast<int>(m_socket.pendingDatagramSize()));
		m_socket.readDatagram(datagram.data(), datagram.size());

		if (m_consumer)
			m_consumer->TakeData(datagram);
	}
}

bool DatagramListener::IsInProgress() const {
	return m_is_in_progress;
}
